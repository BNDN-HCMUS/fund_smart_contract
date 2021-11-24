// SPDX-License-Identifier: MIT
pragma solidity >=0.6.6 <0.9.0;
import "interfaces/AggregatorV3Interface.sol";

contract FundMe{

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    address public owner;
    AggregatorV3Interface public priceFeed;

    constructor(address _priceFeed) public{
        priceFeed = AggregatorV3Interface(_priceFeed);
        owner = msg.sender;
    }
  
    function fund() public payable{
        uint minimumUSD =  50 * 10 ** 18;  
        require(getConversionRate(msg.value) >= minimumUSD, "You need to donate more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }
    
    function getVersion() public view returns (uint256){
        return priceFeed.version();
    }
    
    // 10^18 eth -> USD
    function getPrice() public view returns (uint256){
        (,int256 answer,,,)=priceFeed.latestRoundData();
        return uint256(answer*10000000000);
        // 4259 91213793 0000000000
    }
    
    function getConversionRate(uint256 ethAmouth) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint ethAmountInUsd=(ethPrice*ethAmouth)/1000000000000000000;
        return ethAmountInUsd;
    }

    // return EntraceFee (wei)
    function getEntranceFee() public view returns (uint256){
        uint256 minimumUSD = 50 * 10**18;
        uint256 price = getPrice();
        uint256 precision = 10**18;
        return (minimumUSD*precision)/price;
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    function withdraw() public onlyOwner payable  {
        payable(msg.sender).transfer(address(this).balance);
        for(uint256 i=0;i<funders.length;i++){
            address funder = funders[i];
            addressToAmountFunded[funder]=0;
        }
        funders = new address[](0);
    }
}