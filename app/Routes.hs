module Yacrud.Routes where

import System.IO

routeRequest ("GET":"/":_) = do
  body <- prepareResponseBody "./app/views/home.html"
  sendResponse "200" "Content-Type: text/html\r\n" body

routeRequest ("GET":"/login":_) = do
  body <- prepareResponseBody "./app/views/login.html"
  sendResponse "200" "Content-Type: text/html\r\n" body

routeRequest ("GET":"/register":_) = do
  body <- prepareResponseBody "./app/views/register.html"
  sendResponse "200" "Content-Type: text/html\r\n" body

routeRequest ("POST":"/register":_) = do
  sendResponse "301" "Location: http://10.10.10.42:4000/login\r\n" ""

routeRequest ("POST":"/login":_) = do
  sendResponse "301" "Location: http://10.10.10.42:4000/\r\nSet-Cookie: email=leandro@example.com; path=/; HttpOnly" ""

routeRequest (_) = do
  body <- prepareResponseBody "./app/views/notFound.html"
  sendResponse "200" "Content-Type: text/html\r\n" body

prepareResponseBody fileName = do
  handleFile <- openFile fileName ReadMode
  hGetContents handleFile

sendResponse code headers body = do
  return("HTTP/1.1 " ++ code ++ "\r\n" ++ headers ++ "\r\n" ++ body)
