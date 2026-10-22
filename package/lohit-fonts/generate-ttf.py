# Generate a TTF font from a lohit SFD source with fontforge.
#
# Equivalent of the upstream apply_featurefile.py + generate.pe steps. The
# upstream apply_featurefile.py is Python 2 only, so do it here in Python 3.
#
# usage: fontforge -lang=py -script generate-ttf.py <sfd> <ttf> [<fea>]

import sys
import fontforge

font = fontforge.open(sys.argv[1])
if len(sys.argv) > 3:
    for lookup in font.gsub_lookups + font.gpos_lookups:
        font.removeLookup(lookup)
    font.mergeFeature(sys.argv[3])
font.generate(sys.argv[2])
font.close()
