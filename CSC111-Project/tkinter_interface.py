"""The file containing the Interface class which is able to create a game recommend interface,
 display recommended games, and generate new recommendations.

 Copyright
===============================
This file is Copyright (c) 2021 David Liu, Ruiting Chen, Jiankun Wei, Qianxi Gao, Kexuan Zhang.
"""
import tkinter
from tkinter.messagebox import *
from tkinter.constants import *
from PIL import ImageTk, Image
import steamfront
from functools import partial
from recommender import open_next_web, game_recommender, sort_by_popularity
from game_graph import load_weighted_review_graph, create_game_graph, WeightedGraph, \
    load_game_graph_from_processed
from typing import Optional
import json


######################################################################
# Global variable: the file name of data used by this program.
######################################################################
PATH = "australian_user_reviews.json"


class Interface:
    """
    The game recommending interface created using tkinter.
    It is the main source for the program to collect user input and display recommended games.

    Instance Attributes:
        - like: the set containing games that the user is interested.
        - recommend: the set containing games that are already recommended.
        - curr_recommend: the list containing games that is currently recommending.
        - curr_index: the index of the game that is currently being recommended.
        - start_label: The start label of this Interface.
        - start_button: The start button of this Interface.
        - frames: a dictionary containing all the created frames.
        - graph: The weighted game graph created based on the weighted review graph.
    """
    like: set
    recommend: set
    curr_recommend: list
    curr_index: int
    labels: dict[str, tkinter.Label]
    buttons: dict[str, tkinter.Button]
    frames: dict[str, tkinter.Frame]
    graph: Optional[WeightedGraph] = None

    def __init__(self) -> None:
        """Initialize all the instance attributes of class Interface."""
        self.like = set()
        self.recommend = set()
        self.curr_recommend = []
        self.curr_index = 0
        self.root = tkinter.Tk()
        self.labels = {}
        self.buttons = {}
        self.frames = {}

    def start_recommender(self) -> None:
        """Start a "start" interface for the game recommender."""
        self.root.geometry("500x350")
        self.root.title('Game Recommender')

        top_frame = tkinter.Frame(self.root, bg="black", relief=FLAT, borderwidth=1)
        top_frame.pack(fill=BOTH, expand=1, side=TOP)
        bottom_frame = tkinter.Frame(self.root, bg="#1f0645", relief=FLAT, borderwidth=1)
        bottom_frame.pack(fill=BOTH, expand=1, side=BOTTOM)
        self.frames['top_frame'] = top_frame
        self.frames['bottom_frame'] = bottom_frame

        # Welcome Text
        beginning_label = tkinter.Label(top_frame, bg="black", font=10, fg="white", height=2,
                                        text="Click 'Start' to start the program")
        beginning_label.pack(fill=X, expand=1)
        self.labels['start_label'] = beginning_label

        # Start Button
        beginning_button = tkinter.Button(bottom_frame, text="start", bd=10, height=2, width=30,
                                          bg="#cc8ef5", font=10, command=self.start_command)
        beginning_button.pack()
        self.buttons['start_button'] = beginning_button

        # Load Photo
        photo_label = tkinter.Label(self.root)
        image_file = Image.open('steam_icon.jpg')
        photo_label.img = ImageTk.PhotoImage(image_file)
        photo_label['image'] = photo_label.img
        photo_label.pack()

        self.root.mainloop()

    def start_command(self) -> None:
        """The function for start button.
        It starts the game recommending interface."""
        self.labels['start_label'].destroy()
        self.buttons['start_button'].destroy()
        load_data_label = tkinter.Label(
            self.frames['top_frame'], bg="black", font=10, fg="white",
            height=2, text="Please choose which kind of game data set you want to use")
        load_data_label.pack(fill=X, expand=1)
        self.labels['load_data_label'] = load_data_label

        small_data_button = tkinter.Button(self.frames['bottom_frame'], text="Small", bd=10,
                                           bg="#f7c454", font=8, height=2, width=28,
                                           command=partial(self.load_data_commend, "small"))
        small_data_button.pack(side=LEFT)
        self.buttons['small_data_button'] = small_data_button

        large_data_button = tkinter.Button(self.frames['bottom_frame'], text="Large",
                                           bd=10, bg="#d4cdbe", font=8, height=2, width=28,
                                           command=partial(self.load_data_commend, "large"))
        large_data_button.pack(side=RIGHT)
        self.buttons['large_data_button'] = large_data_button

    def load_data_commend(self, data_size: str):
        """Load the WeightedGraph for the given size of dataset."""
        self.labels['load_data_label'].destroy()
        self.buttons['small_data_button'].destroy()
        self.buttons['large_data_button'].destroy()
        waiting_label = tkinter.Label(self.frames['top_frame'], bg="black",
                                      font=10, fg="white", height=2,
                                      text="Loading data for game recommender. Please be patient.\n"
                                      "This may take a while.")
        waiting_label.pack(fill=X, expand=1, side=LEFT)
        self.labels['waiting_label'] = waiting_label
        author_label = tkinter.Label(self.frames['bottom_frame'], bg="black",
                                     font=10, fg="white", height=2,
                                     text="This program is made possible by\nRuiting Chen, "
                                          "Jiankun Wei, Qianxi Gao, and Kexuan Zhang.")
        author_label.pack(fill=X, expand=1, side=LEFT)
        self.labels['author_label'] = author_label
        self.root.update()

        if data_size == 'small':
            # You can adjust the second parameter of load_weighted_review_graph to load
            # different size of data from australian_user_reviews.json
            # Currently it is set to load first 2000 lines of australian_user_reviews data and
            # takes about 1 minute to load and create a game graph
            reviews_graph = load_weighted_review_graph(PATH, 2000)
            game_graph = create_game_graph(reviews_graph)
        else:
            game_graph = load_game_graph_from_processed('processed_game_graph.txt')
        current_recommend = sort_by_popularity(game_graph,
                                               list(game_graph.get_all_ids('game')), 5)
        self.graph = game_graph
        self.curr_recommend = current_recommend
        self.labels['waiting_label'].destroy()
        self.labels['author_label'].destroy()
        open_next_web(self.curr_recommend, self.curr_index)

        new_label = tkinter.Label(self.frames['top_frame'], bg="black", font=10, fg="white",
                                  height=2, text=f'Do you like this game?\n'
                                                 f'{len(self.like)} game in current interested list'
                                  )
        new_label.pack(fill=X, expand=1, side=LEFT)
        self.labels['new_label'] = new_label
        like_button = tkinter.Button(self.frames['bottom_frame'], text="Interested", bd=10,
                                     bg="#f7c454", font=8, height=2, width=28,
                                     command=partial(self.reaction_commend, "like"))
        like_button.pack(side=LEFT)
        next_button = tkinter.Button(self.frames['bottom_frame'], text="Not Interested", bd=10,
                                     bg="#d4cdbe", font=8, height=2, width=28,
                                     command=partial(self.reaction_commend, "next"))
        next_button.pack(side=RIGHT)
        save_button = tkinter.Button(self.frames['top_frame'], text="Save\ngames\nlist",
                                     bd=4, bg="#bbd8ed", font=10, command=self.save_command)
        save_button.pack(side=RIGHT)

    def reaction_commend(self, reaction: str) -> None:
        """The reaction for "Interested" and "Not Interested" button.
        Update self.like, self.recommend, self.curr_index base on the reaction and open
        the steam website for the next game.

        Generate a new recommend games list if self.curr_recommend is exhausted.

        Precondition:
            - reaction in {"like", "next"}
        """
        if reaction == "like":
            self.like.add(self.curr_recommend[self.curr_index])
            self.labels['new_label']['text'] = f'Do you like this game?\n' \
                                               f'{len(self.like)} game in current interested list'
        self.recommend.add(self.curr_recommend[self.curr_index])

        if self.curr_index < len(self.curr_recommend) - 1:
            self.curr_index += 1
        else:
            self.curr_recommend = game_recommender(self.graph, self.like, self.recommend)
            if self.curr_recommend == []:
                showinfo(title='No More Recommends',
                         message='You have viewed all games in the dataset.\n'
                                 'Please click "ok" to close the program.')
                self.root.destroy()
                return
            self.curr_index = 0

        open_next_web(self.curr_recommend, self.curr_index)

    def save_command(self) -> None:
        """Save current list in my_list.txt file."""
        if self.like == set():
            showinfo(title='Empty Error',
                     message='You have not add any game to your favorite yet.')
        else:
            file = open("my_list.txt", 'w')
            s = ''
            for game in self.like:
                try:
                    s += steamfront.Client().getApp(appid=game).name
                except json.decoder.JSONDecodeError:
                    continue
                s += ": https://store.steampowered.com/app/" + game
                s += '\n'
            file.write(s.strip())
            file.close()
            showinfo(title='Info', message='Saved!')
