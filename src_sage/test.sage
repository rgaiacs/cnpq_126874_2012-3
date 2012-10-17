# Copyright (C) 2012  Raniere Silva <r.gaia.cs@gmail.com>
#
# This file is part of 'CNPq Cuthill-McKee reversa'.
#
# 'CNPq Cuthill-McKee reversa' is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# 'CNPq Cuthill-McKee reversa' is distributed in the hope that it will
# be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Foobar.  If not, see <http://www.gnu.org/licenses/>.

A = matrix([[1, 1, 1, 0, 0],
            [1, 1, 1, 0, 1],
            [1, 1, 1, 1, 0],
            [0, 0, 1, 1, 0],
            [0, 1, 0, 0, 1]]); A

B = matrix([[1, 1, 0, 0, 1, 0],
            [1, 1, 1, 0, 0, 1],
            [0, 1, 1, 0, 1, 0],
            [0, 0, 0, 1, 1, 0],
            [1, 0, 1, 1, 1, 1],
            [0, 1, 0, 0, 1, 1]]); B

C = matrix([[1, 1, 0, 0, 1, 1],
            [1, 1, 1, 1, 0, 1],
            [0, 1, 1, 0, 1, 0],
            [0, 1, 0, 1, 0, 0],
            [1, 0, 1, 0, 1, 1],
            [1, 1, 0, 0, 1, 1]]); C

# Exemplo corespondente a Figura 5.6 da Fernanda.
Z = matrix([[1, 0, 0, 1, 0, 1, 0, 0, 0, 0],
            [0, 1, 1, 0, 1, 0, 1, 0, 0, 1],
            [0, 1, 1, 1, 1, 0, 0, 0, 0, 0],
            [1, 0, 1, 1, 0, 1, 0, 0, 1, 0],
            [0, 1, 1, 0, 1, 0, 1, 0, 0, 0],
            [1, 0, 0, 1, 0, 1, 1, 1, 0, 0],
            [0, 1, 0, 0, 1, 1, 1, 1, 0, 0],
            [0, 0, 0, 0, 0, 1, 1, 1, 0, 0],
            [0, 0, 0, 1, 0, 0, 0, 0, 1, 0],
            [0, 1, 0, 0, 0, 0, 0, 0, 0, 1]])

# Star graph with N = 7 nodes.
# From Wai-Hung Liu and Andrew H. Sherman. Comparative Analysis of the
# Cuthill-McKee ...
S = matrix([[1, 1, 1, 1, 1, 1, 1],
            [1, 1, 0, 0, 0, 0, 0],
            [1, 0, 1, 0, 0, 0, 0],
            [1, 0, 0, 1, 0, 0, 0],
            [1, 0, 0, 0, 1, 0, 0],
            [1, 0, 0, 0, 0, 1, 0],
            [1, 0, 0, 0, 0, 0, 1]])
# print("{0}\n\n".format(Z))
# r = Z.rcm()
# print(Z[r, r])
