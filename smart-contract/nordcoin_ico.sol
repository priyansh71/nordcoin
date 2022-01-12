// Nordcoins ICO
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

contract nordcoin_ico{

    // Introducing total nordcoins available for sale
    uint public max_nordcoins = 1000000;

    // Introducing USD to nordcoins conversion rate
    uint public usd_to_nordcoins = 1000;

    // Introducing total number of nordcoins bought by the investors
    uint public total_nordcoins_bought = 0;

    // Mapping from the investors to its equity in nordcoins and USD
    mapping(address => uint) equity_nordcoins;
    mapping(address => uint) equity_usd;

    // Check if an investor can buy nordcoins
    modifier can_buy_nordcoins(uint usd_invested) {
        require( usd_invested * usd_to_nordcoins + total_nordcoins_bought <= max_nordcoins );
        _;
    }

    // Getting the equity in Nordcoins of the investor
    function equity_in_nordcoins(address investor) external view returns (uint) {
        return equity_nordcoins[investor];
    }

    // Getting the equity in USD of the investor
    function equity_in_usd(address investor) external view returns (uint) {
        return equity_usd[investor];
    }

    // Buying Nordcoins
    function buy_nordcoins(address investor, uint usd_invested) external
    can_buy_nordcoins(usd_invested){
        uint nordcoins_bought = usd_invested * usd_to_nordcoins;
        equity_nordcoins[investor] += nordcoins_bought;
        equity_usd[investor] += usd_invested;
        total_nordcoins_bought += nordcoins_bought;
    }
    
    // Selling Nordcoins
    function sell_nordcoins(address investor, uint nordcoins_sold) external {
        equity_nordcoins[investor] -= nordcoins_sold;
        equity_usd[investor] -= equity_nordcoins[investor] / usd_to_nordcoins;
        total_nordcoins_bought -= nordcoins_sold;
    }

}