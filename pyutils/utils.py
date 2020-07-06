from mfp_table import MACHMFP_TAB
from scipy.interpolate import interp1d

def lookup_M(mfp):
    Ms, mfps = zip(*MACHMFP_TAB)
    interpolator = interp1d(mfps, Ms)
    return interpolator(mfp)

def lookup_mf(M):
    Ms, mfps = zip(*MACHMFP_TAB)
    interpolator = interp1d(Ms, mfps)
    return interpolator(M)

# def lookup_mf(M)::
#     for idx, pair in enumerate(MFP):
#         if pair[0] > M:

