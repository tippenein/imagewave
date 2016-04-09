{-# LANGUAGE OverloadedStrings #-}

module Imagewave.Server (runApp, app) where

import Data.Monoid ((<>))
import Imagewave.Conversion
import Network.HTTP.Types
import Network.Wai (Application)
import Network.Wai.Middleware.Gzip
import Network.Wai.Middleware.RequestLogger
import System.Directory
import System.IO.Unsafe
import qualified Web.Scotty as S

app' :: S.ScottyM ()
app' = do
  S.middleware $ gzip $ def { gzipFiles = GzipCompress }
  S.middleware logStdoutDev

  S.get "/:image_hash" $ do
    i <- S.param "image_hash"
    w <- S.param "w"
    h <- S.param "h"
    let f = resizeImg i w h
    S.file $ unsafePerformIO f

app :: IO Application
app = S.scottyApp app'

runApp :: IO ()
runApp = S.scotty 8080 app'
