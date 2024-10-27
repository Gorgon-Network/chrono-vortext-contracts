// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ChronoVortex is ERC20 {
    string public titleGame = 'Chrono Vortex: Space Conquest';
    constructor() ERC20("Chrono Vortex", "CHV") {
        _mint(msg.sender, 100000000 * (10 ** uint256(decimals())));
    }
}
