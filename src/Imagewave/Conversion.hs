module Imagewave.Conversion where

import Data.Text as T
import Graphics.Image
import Graphics.Image.Processing

resizeImg :: FilePath -> Int -> Int -> IO FilePath
resizeImg imgPath w h = do
  putStrLn $ "reading image at " ++ show imgPath
  f <- readImageRGB imgPath
  let path = "static/thing-resized.png"
  writeImage path $ resize (Bilinear Edge) (w, h) f
  putStrLn $ "wrote image to " ++ show path
  return path
