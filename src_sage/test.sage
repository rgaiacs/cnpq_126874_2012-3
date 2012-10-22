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

"""
    This file is used to compare with the implementation made.

    Star matrix (n = 6).

        sage: A = matrix([[1, 1, 1, 1, 1, 1],
        ...               [1, 1, 0, 0, 0, 0],
        ...               [1, 0, 1, 0, 0, 0],
        ...               [1, 0, 0, 1, 0, 0],
        ...               [1, 0, 0, 0, 1, 0],
        ...               [1, 0, 0, 0, 0, 1]])
        sage: r = A.rcm(); r
        [3, 4, 5, 2, 0, 1]

    Star matrix (n = 7).

        sage: A = matrix([[1, 1, 1, 1, 1, 1, 1],
        ...               [1, 1, 0, 0, 0, 0, 0],
        ...               [1, 0, 1, 0, 0, 0, 0],
        ...               [1, 0, 0, 1, 0, 0, 0],
        ...               [1, 0, 0, 0, 1, 0, 0],
        ...               [1, 0, 0, 0, 0, 1, 0],
        ...               [1, 0, 0, 0, 0, 0, 1]])
        sage: r = A.rcm(); r
        [3, 4, 5, 6, 2, 0, 1]

    Star matrix (n = 8).

        sage: A = matrix([[1, 1, 1, 1, 1, 1, 1, 1],
        ...               [1, 1, 0, 0, 0, 0, 0, 0],
        ...               [1, 0, 1, 0, 0, 0, 0, 0],
        ...               [1, 0, 0, 1, 0, 0, 0, 0],
        ...               [1, 0, 0, 0, 1, 0, 0, 0],
        ...               [1, 0, 0, 0, 0, 1, 0, 0],
        ...               [1, 0, 0, 0, 0, 0, 1, 0],
        ...               [1, 0, 0, 0, 0, 0, 0, 1]])
        sage: r = A.rcm(); r
        [3, 4, 5, 6, 7, 2, 0, 1]

    To test if can handle with disconex matrix.
    Disconex stars matrix (n = 4).

        sage: A = matrix([[1, 1, 1, 1, 0, 0, 0, 0],
        ...               [1, 1, 0, 0, 0, 0, 0, 0],
        ...               [1, 0, 1, 0, 0, 0, 0, 0],
        ...               [1, 0, 0, 1, 0, 0, 0, 0],
        ...               [0, 0, 0, 0, 1, 1, 1, 1],
        ...               [0, 0, 0, 0, 1, 1, 0, 0],
        ...               [0, 0, 0, 0, 1, 0, 1, 0],
        ...               [0, 0, 0, 0, 1, 0, 0, 1]])
        sage: r = A.rcm(); r
        [7, 6, 4, 5, 3, 2, 0, 1]

    To test if can handle with disconex matrix.

        sage: A = matrix([[1, 1, 0, 0, 0, 0, 0],
        ...               [1, 1, 1, 0, 0, 0, 0],
        ...               [0, 1, 1, 0, 0, 0, 0],
        ...               [0, 0, 0, 1, 1, 1, 0],
        ...               [0, 0, 0, 1, 1, 1, 1],
        ...               [0, 0, 0, 1, 1, 1, 0],
        ...               [0, 0, 0, 0, 1, 0, 1]])
        sage: r = A.rcm(); r
        [6, 4, 5, 3, 2, 1, 0]

    Exemplo corespondente a Figura 5.6 da Fernanda.

        sage: A = matrix([[1, 0, 0, 1, 0, 1, 0, 0, 0, 0],
        ...               [0, 1, 1, 0, 1, 0, 1, 0, 0, 1],
        ...               [0, 1, 1, 1, 1, 0, 0, 0, 0, 0],
        ...               [1, 0, 1, 1, 0, 1, 0, 0, 1, 0],
        ...               [0, 1, 1, 0, 1, 0, 1, 0, 0, 0],
        ...               [1, 0, 0, 1, 0, 1, 1, 1, 0, 0],
        ...               [0, 1, 0, 0, 1, 1, 1, 1, 0, 0],
        ...               [0, 0, 0, 0, 0, 1, 1, 1, 0, 0],
        ...               [0, 0, 0, 1, 0, 0, 0, 0, 1, 0],
        ...               [0, 1, 0, 0, 0, 0, 0, 0, 0, 1]])
        sage: r = A.rcm(); r
        [9, 1, 4, 6, 7, 2, 8, 5, 3, 0]

    Other exemples.

        sage: A = matrix([[1, 1, 1, 0, 0],
        ...               [1, 1, 1, 0, 1],
        ...               [1, 1, 1, 1, 0],
        ...               [0, 0, 1, 1, 0],
        ...               [0, 1, 0, 0, 1]])
        sage: r = A.rcm(); r
        [3, 2, 0, 1, 4]

        sage: A = matrix([[1, 1, 0, 0, 1, 0],
        ...               [1, 1, 1, 0, 0, 1],
        ...               [0, 1, 1, 0, 1, 0],
        ...               [0, 0, 0, 1, 1, 0],
        ...               [1, 0, 1, 1, 1, 1],
        ...               [0, 1, 0, 0, 1, 1]])
        sage: r = A.rcm(); r
        [3, 5, 2, 4, 1, 0]

        sage: A = matrix([[1, 1, 0, 0, 1, 1],
        ...               [1, 1, 1, 1, 0, 1],
        ...               [0, 1, 1, 0, 1, 0],
        ...               [0, 1, 0, 1, 0, 0],
        ...               [1, 0, 1, 0, 1, 1],
        ...               [1, 1, 0, 0, 1, 1]])
        sage: r = A.rcm(); r
        [3, 2, 1, 5, 4, 0]
"""
