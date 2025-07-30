import logo from './logo.svg';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <a
          className="App-link"
          href="https://tcc.tis.trane.com/"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn Jenkins for Trane
        </a>
      </header>
      <p>
          Application version: 1.2
      </p>
    </div>
  );
}

export default App;
