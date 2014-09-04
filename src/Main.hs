module Main where

import Web.Scotty

import Staff

main :: IO ()
main = scotty 3000 $ do
    post "/staff" createStaff
