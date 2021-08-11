*** Settings ***
Documentation                         Documentação API:  https://fakerestapi.azurewebsites.net/api/v1/Books
Library                               SeleniumLibrary
Library                               RequestsLibrary
Library                               Collections
Library                               JSONLibrary

# robot -d ./reports  test_case/TestCaseAPI.robot 

*** Variables ***
${URL_API}                            https://fakerestapi.azurewebsites.net/api/v1/
&{BOOK_15}                            id=15
...                                   title=Book 15
...                                   pageCount=1500
&{BOOK_16}                            id=16
...                                   title=Book 16
...                                   pageCount=1600
&{BOOK_NEW}                           id=42
...                                   title=Book 42
...                                   description=test
...                                   pageCount=4200
...                                   excerpt=test
...                                   publishDate=2021-08-11T02:35:20.446Z


