{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty (html, get, scotty)

main :: IO ()
main = scotty 3000 $ do
    get "/" $ do
        html "Hello world."
