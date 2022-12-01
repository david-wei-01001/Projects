"""The main file for this program.
It contains the main function for running the whole program.

Copyright
===============================
This file is Copyright (c) 2021 David Liu, Ruiting Chen, Jiankun Wei, Qianxi Gao, Kexuan Zhang.
"""
from tkinter_interface import Interface


def main() -> None:
    """The main function of the program.
    it reads the australian_user_reviews data, generate WeightedGraph based on the data
    and recommend games based on user's preferences."""
    program = Interface()
    program.start_recommender()


if __name__ == "__main__":
    main()
