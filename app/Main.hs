module Main where

import Network.Socket
import System.IO

main :: IO ()
main = do
  sock <- socket AF_INET Stream 0
  setSocketOption sock ReuseAddr 1
  bind sock (SockAddrInet 4000 0)
  listen sock 2
  putStrLn "Listening..."
  loopForever sock

loopForever :: Socket -> IO ()
loopForever sock = do
  conn <- accept sock
  putStrLn "--New connection arrived--"
  handleConn conn
  loopForever sock

handleConn :: (Socket, SockAddr) -> IO ()
handleConn (sock, _) = do
  handleSock <- socketToHandle sock ReadWriteMode
  hSetBuffering handleSock NoBuffering
  request <- hGetLine handleSock
  putStrLn $ ("Request: " ++ request)
  hPutStrLn handleSock $ ("Hey, client")
  hClose handleSock
