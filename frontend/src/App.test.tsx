import React from 'react';
import { render, screen } from '@testing-library/react';
import App from './App';

test('renders React + FastAPI Starter title', () => {
  render(<App />);
  const titleElement = screen.getByText(/React \+ FastAPI Starter/i);
  expect(titleElement).toBeInTheDocument();
});

test('shows backend health status', () => {
  render(<App />);
  const healthElement = screen.getByText(/Backend health:/i);
  expect(healthElement).toBeInTheDocument();
});
