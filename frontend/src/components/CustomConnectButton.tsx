import { ConnectButton } from '@rainbow-me/rainbowkit'
import { NextComponentType } from 'next'

const CustomConnectButton: NextComponentType = () => {
  return (
    <ConnectButton.Custom>
      {({
        account,
        chain,
        openAccountModal,
        openChainModal,
        openConnectModal,
        mounted,
      }) => {
        const connected = mounted && account && chain

        return (
          <div
            {...(!mounted && {
              'aria-hidden': true,
              style: {
                opacity: 0,
                pointerEvents: 'none',
                userSelect: 'none',
                background: '#686868',
              },
            })}
          >
            {(() => {
              if (!connected) {
                return (
                  <button
                    onClick={openConnectModal}
                    className="bg-gray-600 text-[#FFFFFF] rounded-full w-56 h-10 self-stretch flex-grow ml-auto"
                    type="button"
                  >
                    connect wallet
                  </button>
                )
              }

              if (chain.unsupported) {
                return (
                  <button
                    onClick={openChainModal}
                    className="bg-gray-600 text-[#FFFFFF] rounded-full w-56 h-10 self-stretch flex-grow ml-auto"
                    type="button"
                  >
                    wrong network
                  </button>
                )
              }

              return (
                <div style={{ display: 'flex', gap: 12 }}>
                  <button
                    onClick={openAccountModal}
                    className="bg-gray-600 text-[#FFFFFF] rounded-full w-56 h-10 self-stretch flex-grow ml-auto"
                    type="button"
                  >
                    {account.displayName}
                  </button>
                </div>
              )
            })()}
          </div>
        )
      }}
    </ConnectButton.Custom>
  )
}

export default CustomConnectButton
