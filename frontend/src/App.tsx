import React, { useEffect, useState } from 'react';
import './App.css';

function App() {
  const [health, setHealth] = useState<string>('loading');

  useEffect(() => {
    fetch('/api/v1/health')
      .then(r => r.json())
      .then(d => setHealth(d.status))
      .catch(() => setHealth('error'));
  }, []);

  return (
    <div className="App">
      <h1>React + FastAPI Starter</h1>
      <p>Backend health: {health}</p>
    </div>
  );
}

export default App;
