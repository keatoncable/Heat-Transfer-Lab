import pandas as pd
import os

perfdf = pd.read_excel('sphereexp.xlsx')
perfdf.to_latex('sphereexp.tex')
statsdf = pd.read_excel('cube_exp.xlsx')
statsdf.to_latex('cubeexp.tex')
uncertdf = pd.read_excel('sphcomp.xlsx')
uncertdf.to_latex('sphcomp.tex')
perfdf = pd.read_excel('cucomp.xlsx')
perfdf.to_latex('cucomp.tex')
