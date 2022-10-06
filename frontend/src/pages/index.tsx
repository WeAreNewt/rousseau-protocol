import type { NextPage } from 'next'
import Header from '../components/Header'
import EligibilityBanner from '../components/ElegibilityBanner'
import ValueTable from '../components/ValueTable'

const Home: NextPage = () => {
  return (
    <main className="flex flex-col content-center items-center relative p-0">
      <Header />
      <EligibilityBanner />
      <ValueTable />
    </main>
  )
}

export default Home
