//
//  User.swift
//  LoginApp
//
//  Created by Andrey Zhivotov on 17.03.2022.
//

struct User {
    let login: String
    let password: String
    let person: Person
    
    static func getUserInfo() -> User {
        User(
            login: "User",
            password: "Password",
            person:
                Person(
                    name: "Andrey",
                    surname: "Zhivotov",
                    info: "Привет! меня зовут Андрей. Мне 31, занимаюсь бизнесом в сфере мобильных телефонов, люблю природу и путешествия. Увлекаюсь игрой на гитаре и автомобилями. Идея научится программировать на swift появилась еще 5 лет назад, когда начал углубляться в специфику техники Apple. Надеюсь у меня получится, хоть и оказалось трудней чем я думал :)")
            )
    }
}

struct Person {
    let name: String
    let surname: String
    let info: String
}
