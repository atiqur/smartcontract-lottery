// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import '@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol';

contract Lottery {
    address payable[] public players;
    uint256 public usdEntryFee;
    AggregatorV3Interface internal ethUsdPriceFeed;

    constructor(address _priceFeedAddress) public {
        usdEntryFee = 50 * (10**18);
        ethUsdPriceFeed = AggregatorV3Interface(_priceFeedAddress);
    }

    function entry() public payable {
        // $50 minimum
        players.push(msg.sender);
    }

    function getEntranceFee() public view returns (uint256) {
        (, int256 price, , , ) = ethUsdPriceFeed.latestRoundData(); // return price in 8 decimals
        uint256 adjustedPrice = uint256(price) * 10**10; // converted to 18 decimals
        uint256 costToEnter = (usdEntryFee * 10**18) / adjustedPrice; // 10**18 so that the final answer has 18 decimals
        return costToEnter;
    }

    function startLottery() public {}

    function endLottert() public {}
}
