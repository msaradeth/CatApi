//
//  TestCatViewModel.swift
//  CatApiTests
//
//  Created by Mike Saradeth on 3/17/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import XCTest
@testable import CatApi


class TestCatViewModel: XCTestCase {
    var cat = Cat(breads: [], id: "1", url: "https://cdn2.thecatapi.com/images/4ni.jpg", isMyFavorite: false)
    var cat2 = Cat(breads: [], id: "2", url: "https://cdn2.thecatapi.com/images/4ni.png", isMyFavorite: false)
    var cat22 = Cat(breads: [], id: "22", url: "https://cdn2.thecatapi.com/images/4ni.png", isMyFavorite: false)
    var cat3 = Cat(breads: [], id: "3", url: "https://cdn2.thecatapi.com/images/4ni.gif", isMyFavorite: false)
    var cat33 = Cat(breads: [], id: "33", url: "https://cdn2.thecatapi.com/images/4ni.gif", isMyFavorite: false)
    var cat333 = Cat(breads: [], id: "333", url: "https://cdn2.thecatapi.com/images/4ni.gif", isMyFavorite: false)
    
    var viewModel:CatViewModel!
}


// MARK: - Test CatType.all
extension TestCatViewModel {
    func testIsLoadDataAllCat() {
        viewModel = CatViewModel(catType: .all)
        let cats = [cat, cat2, cat3]
        viewModel.cats[viewModel.currCatType.getIndex()] = cats
        XCTAssertEqual(cats == viewModel.displayCats, true)
    }

    func testIsNOTLoadDataAllCat() {
        viewModel = CatViewModel(catType: .all)
        let cats = [cat, cat2, cat3]
        let otherCats = [cat22, cat33]
        viewModel.cats[viewModel.currCatType.getIndex()] = cats
        XCTAssertEqual(otherCats == viewModel.displayCats, false)
    }
}


// MARK: - Test CatType.jpeg
extension TestCatViewModel {
    func testIsLoadDataJpegCat() {
        viewModel = CatViewModel(catType: .jpg)
        let cats = [cat, cat2, cat3]
        viewModel.cats[viewModel.currCatType.getIndex()] = cats
        XCTAssertEqual(cats == viewModel.displayCats, true)
    }
    
    func testIsNOTLoadDataJpegCat() {
        viewModel = CatViewModel(catType: .jpg)
        let cats = [cat, cat2, cat3]
        let otherCats = [cat22, cat33]
        viewModel.cats[viewModel.currCatType.getIndex()] = cats
        XCTAssertEqual(otherCats == viewModel.displayCats, false)
    }
}


// MARK: - Test CatType.favorite
extension TestCatViewModel {
    func testIsLoadDataFavoriteCat() {
        viewModel = CatViewModel(catType: .favorite)
        cat.isMyFavorite = true
        let cats = [cat, cat2, cat3]
        viewModel.cats[CatType.all.getIndex()] = cats
        XCTAssertEqual([cat] == viewModel.displayCats, true)
    }
    
    func testIsNOTLoadDataFavoriteCat() {
        viewModel = CatViewModel(catType: .favorite)
        cat.isMyFavorite = true
        let cats = [cat, cat2, cat3]
        let otherCats = [cat22, cat33]
        viewModel.cats[CatType.all.getIndex()] = cats
        XCTAssertEqual(otherCats == viewModel.displayCats, false)
    }
}


// MARK: - Test toggle Favorite from TypeAll section (tap)
extension TestCatViewModel {
    func testIsToggleFavoriteTypeAllSection() {
        viewModel = CatViewModel(catType: .all)
        let cats = [cat, cat2, cat3]
        viewModel.cats[CatType.all.getIndex()] = cats
        viewModel.toggleFavorite(index: 0)
        let aDisplayCat = viewModel.displayCats[0]
        XCTAssertEqual(aDisplayCat.isMyFavorite == true, true)
    }
    
    func testIsNotToggleFavoriteTypeAllSection() {
        viewModel = CatViewModel(catType: .all)
        let cats = [cat, cat2, cat3]
        viewModel.cats[CatType.all.getIndex()] = cats
        viewModel.toggleFavorite(index: 0)
        let aDisplayCat = viewModel.displayCats[0]
        XCTAssertEqual(aDisplayCat.isMyFavorite == false, false)
    }
}



// MARK: - Test toggle Favorite from TypeFavorite section (tap)
extension TestCatViewModel {
    func testIsToggleFavoriteTypeFavoriteSection() {
        viewModel = CatViewModel(catType: .favorite)
        cat.isMyFavorite = true
        cat2.isMyFavorite = true
        cat3.isMyFavorite = true
        let cats = [cat, cat2, cat3]
        viewModel.cats[CatType.all.getIndex()] = cats
        viewModel.toggleFavorite(index: 0)
        
        //Show not find the cat ID of the cat because it is toggle to false
        for aFavoriteCat in viewModel.displayCats {
            XCTAssertEqual(aFavoriteCat.id == cat.id, false)
        }
    }
}


// And test the rest of the fuctions
