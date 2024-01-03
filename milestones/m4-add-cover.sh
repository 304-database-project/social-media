#!/bin/bash
# m4-cover.pdf is the cover for milestone 4
# m4-no-cover is the rest of milestone 4, rendered by Obsidian
# The result of the merge is Milestone 4.pdf
pdftk m4-cover.pdf m4-no-cover.pdf cat output Milestone\ 4.pdf