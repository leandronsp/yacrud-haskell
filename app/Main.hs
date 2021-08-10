module Main where

import Network.Socket
import System.IO

import Request

main :: IO ()
main = do
  sock <- socket AF_INET Stream 0
  setSocketOption sock ReuseAddr 1
  bind sock (SockAddrInet 4000 0)
  listen sock 2
  putStrLn "Listening on port 4000..."
  loopForever sock

loopForever :: Socket -> IO ()
loopForever sock = do
  conn <- accept sock
  handleConn conn
  loopForever sock

handleConn :: (Socket, SockAddr) -> IO ()
handleConn (sock, _) = do
  handleSock <- socketToHandle sock ReadWriteMode
  hSetBuffering handleSock NoBuffering
  response <- processRequest handleSock
  hPutStrLn handleSock $ response
  hClose handleSock
