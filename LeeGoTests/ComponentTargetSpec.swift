

import Foundation
import UIKit

import Quick
import Nimble
@testable import LeeGo

class ComponentTargetSpec: QuickSpec {
    override func spec() {

        describe("ComponentTarget tests") {

            it("should create a new component target instance correctly") {
                let component = ComponentTarget(name: "title", targetClass: UILabel.self).width(40).style([.backgroundColor(UIColor.greenColor())])
                expect(component.name) == "title"
                expect(component.targetClass == UILabel.self)
                expect(component.width) == 40
                if case let .backgroundColor(color) = component.style.first! {
                    expect(color) == UIColor.greenColor()
                }
            }

            it("should create a new component with subcomponents", closure: { () -> () in
                let mockLayout = Layout()

                let component = ComponentTarget(name: "header", targetClass: UIView.self).components(ComponentTarget(name: "title", targetClass: UILabel.self), layout: { (title) -> Layout in
                    expect(title) == "title"
                    return mockLayout
                })
                expect(component.components?.count) == 1
                expect(component.components?.last?.name) == "title"
                expect(component.layout) == mockLayout
            })

            it("should create a new component with subcomponents", closure: { () -> () in

                let mockLayout = Layout()

                let component = ComponentTarget(name: "header", targetClass: UIView.self).components(ComponentTarget(name: "title", targetClass: UILabel.self), ComponentTarget(name: "avatar", targetClass: UIImageView.self), layout: { (title, avatar) -> Layout in
                    expect(title) == "title"
                    expect(avatar) == "avatar"
                    return mockLayout
                })
                expect(component.components?.count) == 2
                expect(component.components?.last?.name) == "avatar"
                expect(component.layout) == mockLayout
            })

            it("should create a new component with subcomponents", closure: { () -> () in
                let mockLayout = Layout()

                let component = ComponentTarget(name: "header", targetClass: UIView.self).components(TestData.title1, TestData.avatar1, TestData.view, layout: { (title, avatar, view) -> Layout in
                    expect(title) == "title"
                    expect(avatar) == "avatar"
                    expect(view) == "view"
                    return mockLayout
                })
                expect(component.components?.count) == 3
                expect(component.components?.last?.name) == "view"
                expect(component.layout) == mockLayout
            })

            it("should create a new component with subcomponents", closure: { () -> () in
                let mockLayout = Layout()

                let component = ComponentTarget(name: "header", targetClass: UIView.self).components(TestData.title1, TestData.avatar1, TestData.view, TestData.title3, layout: { (title, avatar, view, title3) -> Layout in
                    expect(title) == "title"
                    expect(avatar) == "avatar"
                    expect(view) == "view"
                    expect(title3) == "title3"
                    return mockLayout
                })
                expect(component.components?.count) == 4
                expect(component.components?.last?.name) == "title3"
                expect(component.layout) == mockLayout
            })

            it("should create a new component with subcomponents", closure: { () -> () in
                let mockLayout = Layout()

                let component = ComponentTarget(name: "header", targetClass: UIView.self).components(TestData.title1, TestData.avatar1, TestData.view, TestData.title3, TestData.header2, layout: { (title, avatar, view, title3, header2) -> Layout in
                    expect(title) == "title"
                    expect(avatar) == "avatar"
                    expect(view) == "view"
                    expect(title3) == "title3"
                    expect(header2) == "header2"
                    return mockLayout
                })
                expect(component.components?.count) == 5
                expect(component.components?.last?.name) == "header2"
                expect(component.layout) == mockLayout
            })

            it("should create a new component with subcomponents", closure: { () -> () in
                let mockLayout = Layout()

                let component = ComponentTarget(name: "header", targetClass: UIView.self).components([TestData.title1, TestData.avatar1], layout: mockLayout)
                expect(component.components?.count) == 2
                expect(component.components?.last?.name) == "avatar"
                expect(component.layout) == mockLayout
            })

            it("should build component target instance", closure: { () -> () in
                let component = ComponentBuilder.header.build()
                expect(component.name) == "header"
                expect(component.targetClass == UIView.self)
            })

            it("should build component target instance from nib", closure: { () -> () in
                let component = ComponentBuilder.title.buildFromNib(name: "nibname")
                expect(component.name) == "title"
                expect(component.targetClass == UILabel.self)
                expect(component.nibName) == "nibname"
            })
        }
    }
}













