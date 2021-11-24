1. Deploy on rinkeby
2. Verify contract để người khác có thể tương tác một cách dễ dàng
    api key nhằm giúp import@ hoạt động trong etherscan
3. Khi làm việc trên local không thể tương tác với contract khác ở on-chain. Có 2 cách giải quyết
    3.1. Mock (fake chain)
    3.2. Forking
4. Deploy brownie trên các network khác nhau: 
    testnet: rinkeby
    local: development (ganache-cli, brownie coi network này là tạm thời), ganache-local (network bền vững)
    forked-local: mainnet-fork, mainnet-fork-dev

Tóm tắt video:
    - Deploy trên rinkeby (có thể lấy pricefeed từ 1 contract khác)
    - Deploy trên ganache (không thể lấy pricefeed nên phải giả lập 1 contract chứa pricefeed. Có thể khởi tạo giá trị cho contract này)
    - Pytest nhằm test trên local


brownie run scripts/deploy.py network rinkeby
brownie networks add Ethereum ganache-local host=http://127.0.0.1:7545 chainid=1337
        development (tạm thời): 8545
        mainnet-fork-dev (tạm thời): tự tạo
        mainnet-fork (tạm thời): của brownie tạo
        ganache-local (bền vững): 7545
brownie networks delete ganache-local

forking từ infura thường gặp vấn đề nên sẽ forking từ alchemy
ctr + e: recently open
==========================
1 eth = 4000 $
1 gwei = 4000 / (10**9)
1 wei = 4000 / (10**18)

=>
10^18 eth = 4000 * 10^18
10^18 gwei = 4000 * 10^9
10^18 wei = 4000 