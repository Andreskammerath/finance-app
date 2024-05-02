"use client";
import React, { useState, useEffect } from 'react';

const HomePage = () => {
    const [email, setEmail] = useState('');
    const [transactions, setTransactions] = useState([]);
    const [error, setError] = useState('');

    useEffect(() => {
        // Retrieve stored values securely
        const storedEmail = typeof window !== 'undefined' ? localStorage.getItem('email') : null;
        const storedToken = typeof window !== 'undefined' ? localStorage.getItem('token') : null;

        setEmail(storedEmail);

        // Debugging output to console (remove in production)
        console.log('Stored Email:', storedEmail);
        console.log('Stored Token:', storedToken);

        const fetchTransactions = async () => {
            if (!storedToken) {
                setError('No token available');
                return; // Exit if no token is available
            }

            try {
                const response = await fetch('http://localhost:8000/transactions/?period=04-2024', {
                    method: 'GET',
                    headers: {
                        'Accept-Language': 'en-US,en;q=0.9,es;q=0.8',
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${storedToken}`,
                        'Accept': 'application/json',
                    },
                });

                if (!response.ok) {
                    throw new Error('Failed to fetch transactions');
                }

                const data = await response.json();
                setTransactions(data.transactions);  // Adjust this depending on the structure of the response
            } catch (error) {
                setError('Failed to fetch transactions');
                console.error('Fetch Error:', error);
            }
        };

        fetchTransactions();
    }, []);

    return (
        <div>
            <h1>Welcome, {email}</h1>
            {error && <p>Error: {error}</p>}
            <h2>Transactions</h2>
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Description</th>
                        <th>Amount</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    {transactions.map((transaction, index) => (
                        <tr key={index}>
                            <td>{transaction.date}</td>
                            <td>{transaction.description}</td>
                            <td>{transaction.amount}</td>
                            <td>{transaction.status}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default HomePage;

