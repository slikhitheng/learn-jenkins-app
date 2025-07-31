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
          Open Command Center
        </a>
      </header>
      <p>
          Application version: 1.4
      </p>
    </div>
  );
}

export default App;
