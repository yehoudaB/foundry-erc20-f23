// SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;
    DeployOurToken public deployer;
    address public bob = makeAddr("bob");
    address public alice = makeAddr("alice");

    uint256 public constant BOB_STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob, BOB_STARTING_BALANCE);
    }

    function testBobBalance() public {
        assertEq(ourToken.balanceOf(bob), BOB_STARTING_BALANCE);
    }

    function testAllowancesWorks() public {
        uint256 initialAllowance = 1000;
        uint256 transferAmount = 500;
        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);

        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);
        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(
            ourToken.balanceOf(bob),
            BOB_STARTING_BALANCE - transferAmount
        );
    }
}
