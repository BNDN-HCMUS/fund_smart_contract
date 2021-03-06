from brownie import FundMe
from brownie.network import account
from scripts.helpfulscripts import get_account

def fund():
    fund_me = FundMe[-1]
    account = get_account()
    entrance_fee = fund_me.getEntraceFee()
    print(entrance_fee)
    print(f"The current entry fee is {entrance_fee}")
    print("funding ... ")
    fund_me.fund({"from": account, "value": entrance_fee})

def withdraw():
    fund_me = FundMe[-1]
    account = get_account()
    fund_me.withdraw({"from": account})

def main():
    fund()
    withdraw()