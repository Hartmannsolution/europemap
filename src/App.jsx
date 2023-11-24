import { useState } from 'react'
import reactLogo from './assets/react.svg'
import europeSVG from './assets/europe.svg'
import Europe from './components/europemap/Europe'
import viteLogo from '/vite.svg'
import './App.css'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <h1>Europe</h1>
      <Europe />
    </>
  )
}

export default App
