module Imagewave.Conversion where

import Graphics.Image.Processing.Geometric

resizeImg imgPath w h = do
  f <- readImageRGB imgPath
  writeImage "static/thing.png" $ resize (Bilinear Edge) (w, h) f
