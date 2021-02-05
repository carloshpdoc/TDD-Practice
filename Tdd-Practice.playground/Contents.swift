import Foundation
import XCTest

class ScoreRegister {
    var availableFunds: Decimal
    var transactionTotal: Decimal = 0
    
    init(availableFunds: Decimal) {
        self.availableFunds = availableFunds
    }
    
    func addItem(_ cost: Decimal) {
        transactionTotal += cost
    }
    
    func acceptCashPayment(_ cash: Decimal) {
        transactionTotal -= cash
        availableFunds += cash
    }
}


class ScoreRegisterTests: XCTestCase {
    var availableFunds: Decimal!
    var itemCost: Decimal!
    var payment: Decimal!
    
    var sut: ScoreRegister!
    
    override func setUp() {
        super.setUp()
        availableFunds = 100
        itemCost = 42
        payment = 40.0
        sut = ScoreRegister(availableFunds: availableFunds)
    }
    
    override func tearDown() {
        availableFunds = nil
        itemCost = nil
        payment = nil
        sut = nil
        super.tearDown()
    }

    func testInitAvailableFunds_setsAvailableFunds() {
        XCTAssertEqual(sut.availableFunds, availableFunds)
    }
    
    func testAddItem_oneItem_addCostToTransaction() {
        // when
        sut.addItem(itemCost)
        
        // then
        XCTAssertEqual(sut.transactionTotal, itemCost)
    }
    
    func testAddItem_twoItems_addCostToTransaction() {
        //given
        let itemCostTwo = Decimal(20)
        let expectedTotal = itemCost + itemCostTwo
        
        // when
        sut.addItem(itemCost)
        sut.addItem(itemCostTwo)
        
        // then
        XCTAssertEqual(sut.transactionTotal, expectedTotal)
    }
    
    func testAcceptCashPayment_subtractsPaymentFromTransactionTotal() {
        //given
        givenTransactionInProgress()
        let expected = sut.transactionTotal - payment

        // When
        sut.acceptCashPayment(payment)
        
        //Then
        XCTAssertEqual(sut.transactionTotal, expected)
    }
    
    func testAcceptCashPayment_addsPaymentToAvailableFunds() {
        // given
        givenTransactionInProgress()
        let expected = sut.availableFunds + payment
        
        // When
        sut.acceptCashPayment(payment)
        
        // Then
        XCTAssertEqual(sut.availableFunds, expected)
    }
    
    func givenTransactionInProgress() {
        sut.addItem(50)
        sut.addItem(100)
    }
    
    
}

ScoreRegisterTests.defaultTestSuite.run()
