module Staff where

import Control.Applicative
import Control.Exception
import Control.Monad
import Data.Aeson
import Debug.Trace
import Network.HTTP.Types.Status
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

instance ToJSON Staff where
    toJSON s = object [ "id"    .= getId s,
                        "name"  .= getName s,
                        "email" .= getEmail s ]

createStaff :: ActionM ()
createStaff = flip rescue errorResponse $ do
        name  <- param "name"
        email <- param "email"
        let staff = Staff 1 name email
        traceShow (encode staff) $ text "ok"
    where
        errorResponse _ = do
            status status400
            text "Invalid staff."
