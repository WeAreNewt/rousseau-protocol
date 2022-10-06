import '../styles/globals.css'
import type { AppType } from 'next/dist/shared/lib/utils'
import '@rainbow-me/rainbowkit/styles.css'
import Head from 'next/head'

import { getDefaultWallets, RainbowKitProvider } from '@rainbow-me/rainbowkit'

import { chain, configureChains, createClient, WagmiConfig } from 'wagmi'

import { publicProvider } from 'wagmi/providers/public'

const { chains, provider } = configureChains(
  [chain.polygon, chain.polygonMumbai],
  [publicProvider()]
)

const { connectors } = getDefaultWallets({
  appName: 'Avara Protocol',
  chains,
})

const wagmiClient = createClient({
  autoConnect: true,
  connectors,
  provider,
})

const MyApp: AppType = ({ Component, pageProps }) => {
  return (
    <WagmiConfig client={wagmiClient}>
      <RainbowKitProvider chains={chains}>
        <Head>
          <title>Avara Protocol</title>
        </Head>
        <Component {...pageProps} />
      </RainbowKitProvider>
    </WagmiConfig>
  )
}

export default MyApp
