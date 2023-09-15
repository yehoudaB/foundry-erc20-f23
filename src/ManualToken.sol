// SPDX-Licence-Identifier: MIT

pragma solidity ^0.8.20;

contract ManualToken {
    string public name = "Manual Token";
    mapping(address => uint256) private s_balances;

    function symbol() public pure returns (string memory) {
        return "MANUAL";
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return s_balances[_owner];
    }

    function transfer(address _to, uint256 _value) public {
        uint256 previousBalances = balanceOf(msg.sender) + balanceOf(_to);
        s_balances[msg.sender] -= _value;
        s_balances[_to] += _value;
        require(s_balances[msg.sender] + s_balances[_to] == previousBalances);
    }
}
