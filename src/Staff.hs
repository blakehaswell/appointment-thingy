module Staff where

import Control.Applicative
import Control.Monad
import Data.Aeson
import Debug.Trace
import Web.Scotty

data Staff = Staff { getId    :: Int,
                     getName  :: String,
                     getEmail :: String } deriving (Show)

instance FromJSON Staff where
    parseJSON (Object v) =
        Staff <$> v .: "id"
              <*> v .: "name"
              <*> v .: "email"
    parseJSON _ = mzero

createStaff :: ActionM ()
createStaff = do
    staff <- jsonData :: ActionM Staff
    text $ traceShow staff "ok"
