"""This file contains functions to sort and recommend games based on popularity and relativity
 to games that the user likes. It also contains a function to ope the steam website for each game
recommended.

Copyright
===============================
This file is Copyright (c) 2021 David Liu, Ruiting Chen, Jiankun Wei, Qianxi Gao, Kexuan Zhang.
"""
import webbrowser
from game_graph import WeightedGraph
from typing import Callable, Any


general_url = "http://store.steampowered.com/app/"


def open_next_web(recommend: list, index: int) -> None:
    """Open the steam website of the game at the given index in the recommend list.
    Open Steam main page if the game is not on Steam."""
    game = recommend[index]
    url = general_url + str(game) + "/"
    webbrowser.open(url)


def game_recommender(g: WeightedGraph, like: set, recommended: set) -> list:
    """Return 5 game recommendations base on the game's popularity and the
    current status of like. It will not recommend games that's already recommended.
    If the recommended list has less than 5 elements, it will filled up to 5 elements by elements
    sorted through their popularity."""
    potential_recommend = {}
    for game_id in like:
        neighbours = g.get_neighbours(game_id)
        for neighbour in neighbours:
            if neighbour not in recommended:
                score = g.get_weight(neighbour, game_id) * 0.5 + g.get_popularity(neighbour) * 0.5
                if neighbour not in potential_recommend:
                    potential_recommend[neighbour] = score
                else:
                    potential_recommend[neighbour] += score

    recommend = [(v, k) for k, v in potential_recommend.items()]
    recommend.sort(reverse=True)
    recommend = recommend[0:5]
    final_recommend = []
    for rec in recommend:
        final_recommend.append(rec[1])
    if len(final_recommend) < 5:
        all_not_recommended = list(g.get_all_ids('game') - recommended - set(final_recommend))
        if all_not_recommended != []:
            final_recommend.extend(
                sort_by_popularity(g, all_not_recommended, 5 - len(recommend)))
    return final_recommend


def sort_by_popularity(g: WeightedGraph, game_ids: list, num: int) -> list:
    """Return num most popular games in given game_ids base on game's popularity in graph g.
    It uses _partition and k_largest to help sort the popularity of each game.
    """
    lst_vertex = game_ids
    lst = k_largest(lst_vertex, num, key=lambda x: g.get_vertex(x).popularity)
    lst.reverse()
    return lst


def _partition(lst: list, pivot: Any, key: Callable = None) -> tuple[list, list]:
    """Return a partition of lst with the chosen pivot.

    Return two lists, where the first contains the items in lst
    that are <= pivot, and the second contains the items in lst that are > pivot.
    """
    smaller = []
    bigger = []

    if key is not None:
        for item in lst:
            if key(item) <= key(pivot):
                smaller.append(item)
            else:
                bigger.append(item)

    else:
        for item in lst:
            if item <= pivot:
                smaller.append(item)
            else:
                bigger.append(item)

    return (smaller, bigger)


def k_largest(lst: list, k: int, key: Callable = None) -> list:
    """Return a sorted list containing the k smallest elements of lst.

    It uses the following divide-and-conquer approach (similar to quicksort):
        1. Pick the first element (lst[0]) to be the pivot.
        2. Partition the rest of the list based on the pivot.
        3. Recurse on ZERO, ONE, OR TWO partitions.
        4. Combine the results and return.

    It compares k against the *length of the partitions* to determine
    which partitions (if any) it needs to recurse on.

    Preconditions:
        - 1 <= k <= len(lst)  # Note that this implies lst != []
        - lst does not contain duplicates

    >>> numbers = [10, 5, 20, 1, 15]
    >>> k_largest(numbers, 4)
    [5, 10, 15, 20]
    """
    if k == 1:
        return [max(lst, key=key)]
    pivot = lst[0]
    smaller, bigger = _partition(lst[1:], pivot, key=key)
    if bigger == []:
        smaller_sorted = k_largest(smaller, k - 1, key)
        return smaller_sorted + [pivot]
    elif smaller == []:
        if len(bigger) >= k:
            bigger_sorted = k_largest(bigger, k, key)
            return bigger_sorted
        else:
            bigger_sorted = k_largest(bigger, len(bigger), key)
            return [pivot] + bigger_sorted

    if len(bigger) >= k:
        bigger_sorted = k_largest(bigger, k, key)
        return bigger_sorted
    elif k - len(bigger) == 1:
        bigger_sorted = k_largest(bigger, len(bigger), key)
        return [pivot] + bigger_sorted
    else:
        bigger_sorted = k_largest(bigger, len(bigger), key)
        smaller_sorted = k_largest(smaller, (k - len(bigger) - 1), key)
        return smaller_sorted + [pivot] + bigger_sorted


if __name__ == '__main__':
    import python_ta.contracts
    python_ta.contracts.check_all_contracts()

    import doctest
    doctest.testmod(verbose=True)
