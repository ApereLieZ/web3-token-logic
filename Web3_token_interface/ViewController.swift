//
//  ViewController.swift
//  Web3_token_interface
//
//  Created by Apik on 30.06.2023.
//

import UIKit
import web3swift
import Web3Core

class ViewController: UIViewController {

    override func viewDidLoad() {
        Task {
            await load();
        }
        super.viewDidLoad()
    }
    
    func load() async{
        await checkERC721();
    }
    
    func checkERC20() async{
        let privateKey: String = "input private key"; //here
        let passsword: String = "dXa9qsFPm83G";
        let ethkStore = try! [EthereumKeystoreV3(privateKey: Data.fromHex(privateKey)!, password: passsword)!];
        let keyStore = KeystoreManager(ethkStore);
        
        // Do any additional setup after loading the view.
        let provider = try! await Web3HttpProvider(
            url: URL(string: "https://rpc.qtestnet.org")!,
            network: Networks.Custom(networkID: 35443),
            keystoreManager: keyStore
        );
        
        let web3 = Web3(provider: provider);
        let contract = ERC20(web3:web3,provider:provider,address:EthereumAddress(from:"0xe31dd093a2a0adc80053bf2b929e56abfe1b1632")!);
        
        let res = try! await contract.transfer(from: EthereumAddress(from:"0xbF1823EF5Ca4484517F930c695b07544C2b43Efe")!, to: EthereumAddress(from: "0x4F9dF8222f1aeff62A6b2702Aa7aFa8CDa5A7f69")!, amount: "0.1").writeToChain(password: "0990221440Mama")
        
        print(res);
    }
    
    func checkERC721() async {
        let privateKey: String = "input private key"; // here
        let passsword: String = "dXa9qsFPm83G";
        let ethkStore = try! [EthereumKeystoreV3(privateKey: Data.fromHex(privateKey)!, password: passsword)!];
        let keyStore = KeystoreManager(ethkStore);
        
        // Do any additional setup after loading the view.
        let provider = try! await Web3HttpProvider(
            url: URL(string: "https://rpc.qtestnet.org")!,
            network: Networks.Custom(networkID: 35443),
            keystoreManager: keyStore
        );
        
        let web3 = Web3(provider: provider);
        let contract = ERC721(web3: web3, provider: provider, address: EthereumAddress(from:"0xD8d8311dC97DE294120Fa0787B8C9621692b9353")!)
        
        let res = try! await contract.safeTransferFrom(from: EthereumAddress(from: "0xbF1823EF5Ca4484517F930c695b07544C2b43Efe")!, to: EthereumAddress("0x4F9dF8222f1aeff62A6b2702Aa7aFa8CDa5A7f69")!, originalOwner: EthereumAddress("0xbF1823EF5Ca4484517F930c695b07544C2b43Efe")!, tokenId: 1).writeToChain(password: passsword)
        print(res)
        
    }


}

