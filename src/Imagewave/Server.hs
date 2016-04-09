{-# LANGUAGE OverloadedStrings #-}

module Imagewave.Server (runApp, app) where

import Imagewave.Conversion
import Network.Wai (Application)
import Network.Wai.Middleware.Gzip
import Network.Wai.Middleware.RequestLogger
import qualified Web.Scotty as S

app' :: S.ScottyM ()
app' = do
  S.middleware $ gzip $ def { gzipFiles = GzipCompress }
  S.middleware logStdoutDev

  S.get "/:image_hash" $ do
    hash <- S.param "image_hash"
    resizeImg "thing.png" 250 250
    S.raw $ file "./static/thing.png"

app :: IO Application
app = S.scottyApp app'

runApp :: IO ()
runApp = S.scotty 8080 app'
