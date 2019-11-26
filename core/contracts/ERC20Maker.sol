pragma solidity ^0.5.0;

import "./ERC20Basic.sol";
import "./ERC20Pausable.sol";

contract ERC20Maker{
    /**
     * @dev Modifier to make a function callable by admin.
     */
    modifier onlyAdmin() {
        require(msg.sender == _admin, "Only admin");
        _;
    }

    /**
     * @dev Modifier to make a function callable by admin.
     */
    modifier onlyNotVerified(address _address) {
        require(created[_address], "not exist");
        require(!verified[_address], "already verified");
        _;
    }

    /**
     * @dev Emitted when new token created.
     */
    event NewERC20(
        address indexed _address, string _name, address indexed _owner, bool _pausable
    );

    /**
     * @dev Emitted when a token verified.
     */
    event Verified(address indexed _address);

    address private _admin;
    mapping(address => bool) private verified;
    mapping(address => bool) private created;

    constructor (
    )
        public
    {
        _admin = msg.sender;
    }

    function deploy(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint _initTotalSupply,
        address _owner,
        bool _pausable
    )
        public
    {
        address _newToken = _pausable
        ? address(
            new ERC20Pausable(
                _name,
                _symbol,
                _decimals,
                _initTotalSupply,
                _owner
            )
        )
        : address(
            new ERC20Basic(
                _name,
                _symbol,
                _decimals,
                _initTotalSupply,
                _owner
            )
        );
        created[_newToken] = true;
        emit NewERC20(
            _newToken,
            _name,
            _owner,
            _pausable
        );
    }

    function verify(
        address _address
    )
        public
        onlyAdmin
        onlyNotVerified(_address)
    {
        verified[_address] = true;
        emit Verified(_address);
    }
}