"""This file contains the _WeightedVertex and WeightedGraph classes to store game and review data
as graph. It also contains 2 functions at the end to load review data as a weighted review graph
which contains both user and game as its vertex or a weighted game graph which only contain game
as its vertex.

Copyright
===============================
This file is Copyright (c) 2021 David Liu, Ruiting Chen, Jiankun Wei, Qianxi Gao, Kexuan Zhang.
"""
from __future__ import annotations
from typing import Any, Union, Optional
import ast


class _WeightedVertex:
    """A vertex in a weighted game review graph, used to represent a user or a game.

    Instance Attributes:
        - id: The data stored in this vertex, representing a user or game id.
        - kind: The type of this vertex: 'user' or 'game'.
        - neighbours: The vertices that are adjacent to this vertex, and their corresponding
            edge weights (either -1 or 1, -1 represent a user does not recommend a
            game and 1 represent a user recommends a game)
        - popularity: The popularity of a game. If a vertex is a user, its popularity is 0.0

    Representation Invariants:
        - self not in self.neighbours
        - all(self in u.neighbours for u in self.neighbours)
        - self.kind in {'user', 'game'}
    """
    id: Any
    kind: str
    neighbours: dict[_WeightedVertex, Union[int, float]]
    popularity: float

    def __init__(self, id_: Any, kind: str) -> None:
        """Initialize a new vertex with the given id and kind.

        This vertex is initialized with no neighbours.

        Preconditions:
            - kind in {'user', 'game'}
        """
        self.id = id_
        self.kind = kind
        self.neighbours = {}
        self.popularity = 0.0

    def degree(self) -> int:
        """Return the degree of this vertex."""
        return len(self.neighbours)

    def similarity_score(self, other: _WeightedVertex) -> float:
        """Return the weighted similarity score between this vertex and other.
        """
        if self.degree() == 0 or other.degree() == 0:
            return 0.0
        else:
            neighbour_vertex = list(self.neighbours.keys())
            neighbour_intersect = [id_ for id_ in neighbour_vertex if id_ in set(
                other.neighbours.keys()) and self.neighbours[id_] == other.neighbours[id_]]
            neighbour_union = set(self.neighbours.keys()).union(
                set(other.neighbours.keys()))
            return len(neighbour_intersect) / len(neighbour_union)


class WeightedGraph:
    """A weighted graph used to represent a game review network that keeps track of review scores.
    """
    # Private Instance Attributes:
    #     - _vertices:
    #         A collection of the vertices contained in this graph.
    #         Maps id_ to _WeightedVertex object.
    _vertices: dict[Any, _WeightedVertex]

    def __init__(self) -> None:
        """Initialize an empty graph (no vertices or edges)."""
        self._vertices = {}

    def add_vertex(self, id_: Any, kind: str, popularity: float = 0) -> None:
        """Add a vertex with the given id and kind to this graph.

        The new vertex is not adjacent to any other vertices.
        Do nothing if the given id is already in this graph.

        Preconditions:
            - kind in {'user', 'game'}
        """
        if id_ not in self._vertices:
            self._vertices[id_] = _WeightedVertex(id_, kind)
            self._vertices[id_].popularity = popularity

    def add_edge(self, id1: Any, id2: Any, weight: Union[int, float]) -> None:
        """Add an edge between the two vertices with the given ids in this graph,
        with the given weight.

        If the user recommend this game, then weight = 1; if the user does not recommend this game,
        then weight = -1.

        Raise a ValueError if id1 or id2 do not appear as vertices in this graph.

        Preconditions:
            - id1 != id2
        """
        if id1 in self._vertices and id2 in self._vertices:
            v1 = self._vertices[id1]
            v2 = self._vertices[id2]

            # Add the new edge
            v1.neighbours[v2] = weight
            v2.neighbours[v1] = weight
        else:
            raise ValueError

    def get_popularity(self, id_: Any) -> float:
        """Return popularity of given game.

        Preconditions:
            - id_ in self._vertices
        """
        return self._vertices[id_].popularity

    def get_weight(self, id1: Any, id2: Any) -> Union[int, float]:
        """Return the weight of the edge between the given ids.

        Return 0 if id1 and id2 are not adjacent.

        Preconditions:
            - id1 and id2 are vertices in this graph
        """
        v1 = self._vertices[id1]
        v2 = self._vertices[id2]
        return v1.neighbours.get(v2, 0)

    def get_neighbours(self, id_: Any) -> set:
        """Return a set of the neighbours of the given id_.

        Raise a ValueError if id_ does not appear as a vertex in this graph.
        """
        if id_ in self._vertices:
            v = self._vertices[id_]
            return {neighbour.id for neighbour in v.neighbours}
        else:
            raise ValueError

    def get_vertex(self, id_: Any) -> _WeightedVertex:
        """Return the vertex corresponding to the id

        Preconditions:
            - id_ in self._vertices
        """
        return self._vertices[id_]

    def get_all_ids(self, kind: str = '') -> set:
        """Return a set of all vertex ids in this graph.

        If kind != '', only return the ids of the given vertex kind.

        Preconditions:
            - kind in {'', 'user', 'game'}
        """
        if kind != '':
            return {v.id for v in self._vertices.values() if v.kind == kind}
        else:
            return set(self._vertices.keys())

    def get_similarity_score(self, id1: Any, id2: Any) -> float:
        """Return the similarity score between the two given ids in this graph.

        Raise a ValueError if id1 or id2 do not appear as vertices in this graph.
        """
        if id1 in self._vertices and id2 in self._vertices:
            v1 = self._vertices[id1]
            v2 = self._vertices[id2]
            return v1.similarity_score(v2)
        else:
            raise ValueError

    def update_popularity(self, total: int) -> None:
        """Omitted."""
        for game_id in self._vertices:
            v = self._vertices[game_id]
            if v.kind == 'game':
                v.popularity = v.degree() / total


def load_weighted_review_graph(reviews_file: str, limit: Optional[int] = None) -> WeightedGraph:
    """Return a game review WEIGHTED graph corresponding to the given datasets.

    Preconditions:
        - reviews_file is the path to a .json file corresponding to the game review data
          format described on final report
    """
    g = WeightedGraph()

    with open(reviews_file, encoding='utf-8', mode='r') as f:
        count = 0
        for line in f:
            if (limit is not None) and (count > limit):
                break
            count += 1
            user_review = ast.literal_eval(line)
            g.add_vertex(user_review['user_id'], 'user')
            for review in user_review['reviews']:
                g.add_vertex(review['item_id'], 'game')
                if review['recommend']:
                    weight = 1
                else:
                    weight = -1
                g.add_edge(user_review['user_id'], review['item_id'], weight)

        g.update_popularity(count)
    return g


def create_game_graph(review_graph: WeightedGraph,
                      threshold: float = 0.02) -> WeightedGraph:
    """Return a game graph based on the given review_graph.

    The returned game graph has the following properties:
        1. Its vertex set is exactly the set of game vertices in review_graph
            (items are game ids).
        2. For every two distinct games b1 and b2, let s(b1, b2) be their similarity score.

            - If s(b1, b2) > threshold, there is an edge between b1 and b2 in the game graph
              with weight equal to s(b1, b2).
            - Otherwise, there is no edge between b1 and b2.

    You can adjust threshold to get graph with different edge weight, note that this will change
    the running time of the whole program
    """
    g = WeightedGraph()
    lst_game = review_graph.get_all_ids('game')
    for game in lst_game:
        g.add_vertex(game, "game", review_graph.get_vertex(game).popularity)
    curr_game = 1
    for game1 in lst_game:
        for game2 in lst_game:
            if game1 != game2:
                score = review_graph.get_similarity_score(game1, game2)
                if score > threshold:
                    g.add_edge(game1, game2, score)
        curr_game += 1
    return g


def create_processed_game_data_file(review_graph: WeightedGraph, threshold: float = 0.02) -> None:
    """Create a txt file to store the complete game graph

    The game graph in txt file has the following properties:
    1. Its vertex set is exactly the set of game vertices in review_graph
        (items are game ids).
    2. For every two distinct games b1 and b2, let s(b1, b2) be their similarity score.

        - If s(b1, b2) > threshold, there is an edge between b1 and b2 in the game graph
          with weight equal to s(b1, b2).
        - Otherwise, there is no edge between b1 and b2.

    You can adjust the threshold to create a new processed_game_graph.txt file. The current
    processed_game_graph.txt uses the default threshold 0.02.
    """
    file = open('processed_game_graph.txt', 'w')
    lst_game = review_graph.get_all_ids('game')
    curr_game = 1
    edge = 1
    for game in lst_game:
        file.write(f'{game} {review_graph.get_popularity(game)}\n')
    file.write('SPLIT_FROM_HERE\n')
    for game1 in lst_game:
        print(f'create_game_graph_file is writing data for game number {curr_game}.')
        for game2 in lst_game:
            if game1 != game2:
                score = review_graph.get_similarity_score(game1, game2)
                if score > threshold:
                    edge += 1
                    file.write(f'{game1} {game2} {score}\n')
        curr_game += 1
    file.flush()
    file.close()


def load_game_graph_from_processed(processed_file: str) -> WeightedGraph:
    """Return a game graph corresponding to the given processed_file.

    Preconditions:
        - processed_file is the path to a .txt file corresponding to the processed game
          data format described on final report
    """
    g = WeightedGraph()
    lower_half = False

    with open(processed_file, mode='r') as f:
        for line in f:
            string = line.strip()
            if string == 'SPLIT_FROM_HERE':
                lower_half = True
            elif lower_half is True:
                lst = string.split()
                g.add_edge(lst[0], lst[1], float(lst[2]))
            else:
                lst = string.split()
                g.add_vertex(lst[0], 'game', float(lst[1]))
    return g


if __name__ == '__main__':
    import python_ta.contracts
    python_ta.contracts.check_all_contracts()
