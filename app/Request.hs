module Request where

import Network.Socket
import System.IO
import Data.List.Split

import Routes

processRequest sock = do
  firstLine <- hGetLine sock
  putStrLn firstLine
  readRequest sock "" ""
  routeRequest (splitOn " " firstLine)

readRequest _sock acc "\r"   = return(acc)
readRequest _sock acc "\r\n" = return(acc)

readRequest sock acc _ = do
  line <- hGetLine sock
  putStrLn line
  readRequest (sock) (acc ++ line) line
