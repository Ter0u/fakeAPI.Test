*** Settings ***
Resource                                  ../resources/ResourcesAPI.robot

# robot -d ./reports  test_case/TestCaseAPI.robot 
                          

*** Keywords ***
Conectar a API
    Create Session                        fakeAPI                        ${URL_API}

Requisita todos os livros
    ${RESPOSTA}                           GetRequest                     fakeAPI                       Books
    Log                                   ${RESPOSTA.text}
    Set Test Variable                     ${RESPOSTA}

Confere o status code
    [Arguments]                           ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings            ${RESPOSTA.status_code}        ${STATUSCODE_DESEJADO}

Confere o reason
    [Arguments]                           ${REASON_DESEJADO}
    Should Be Equal As Strings            ${RESPOSTA.reason}             ${REASON_DESEJADO}
    
Confere se retorna "${QT_B}" livros
    Length Should Be                      ${RESPOSTA.json()}             ${QT_B}

Requisita o livro "${LIVRO_ID}"
    ${RESPOSTA}                           GetRequest                     fakeAPI                       Books/${LIVRO_ID}
    Log                                   ${RESPOSTA.text}
    Set Test Variable                     ${RESPOSTA}

Confere se retorna todos os dados do livro específico
    Dictionary Should Contain Item        ${RESPOSTA.json()}             id                            ${BOOK_15.id}
    Dictionary Should Contain Item        ${RESPOSTA.json()}             title                         ${BOOK_15.title}
    Dictionary Should Contain Item        ${RESPOSTA.json()}             pageCount                     ${BOOK_15.pageCount}
    Should Not Be Empty                   ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty                   ${RESPOSTA.json()["description"]}
    Should Not Be Empty                   ${RESPOSTA.json()["publishDate"]}

Cadastra o novo livro    
    ${HEADERS}                            Create Dictionary              content-type=application/json
    ${RESPOSTA}                           Post Request                   fakeAPI                       Books
    ...                                   data={"id": 16,"title": "Book 16","description": "test","pageCount": 82,"excerpt": "test","publishDate": "2021-08-10T21:34:39.596Z"}
    ...                                   headers=${HEADERS}
    Log                                   ${RESPOSTA.text}
    Set Test Variable                     ${RESPOSTA}

Requisita o novo livro cadastrado "${Id_Book}"
    ${RESPOSTA}                           GetRequest                     fakeAPI                       Books/${Id_Book}
    Log                                   ${RESPOSTA.text}
    Set Test Variable                     ${RESPOSTA}

Confere se retorna todos os dados do novo livro
    Dictionary Should Contain Item        ${RESPOSTA.json()}             id                            ${BOOK_16.id}
    Dictionary Should Contain Item        ${RESPOSTA.json()}             title                         ${BOOK_16.title}
    Dictionary Should Contain Item        ${RESPOSTA.json()}             pageCount                     ${BOOK_16.pageCount}
    Should Not Be Empty                   ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty                   ${RESPOSTA.json()["description"]}
    Should Not Be Empty                   ${RESPOSTA.json()["publishDate"]}

Altera o livro
    ${BODY}                               Create Dictionary              data={"ID": 42,"Title": "Book 42","Description": "test","PageCount": "4200","Excerpt": "test","PublishDate": "2021-08-11T02:35:20.446Z"}
    ${HEADERS}                            Create Dictionary              content-type=application/json
    ${RESPOSTA}                           Put Request                    fakeAPI                       Books
    ...                                   headers=${HEADERS}
    Log                                   ${RESPOSTA.text}
    Set Test Variable                     ${RESPOSTA}

Requisita o livro alterado "${Change_Book}"
    ${RESPOSTA}                           Get Request                    fakeAPI                       Books/${Change_Book}
    Log                                   ${RESPOSTA.text}
    Set Test Variable                     ${RESPOSTA}

Confere se retorna todos os dados do livro alterado
    Dictionary Should Contain Item        ${RESPOSTA.json()}             id                            ${BOOK_NEW.id}
    Dictionary Should Contain Item        ${RESPOSTA.json()}             title                         ${BOOK_NEW.title}
    Dictionary Should Contain Item        ${RESPOSTA.json()}             pageCount                     ${BOOK_NEW.pageCount}
    Should Not Be Empty                   ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty                   ${RESPOSTA.json()["description"]}
    Should Not Be Empty                   ${RESPOSTA.json()["publishDate"]}

Deleta o livro "${Books_Del}"
    ${RESPOSTA}                           Delete Request                 fakeAPI                       Books/${Books_Del}    
    Log                                   ${RESPOSTA.text}
    Set Test Variable                     ${RESPOSTA}
