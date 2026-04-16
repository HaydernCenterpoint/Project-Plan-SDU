import { defineConfig, loadEnv } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '');
  const apiUrl = env.VITE_BACKEND_URL || 'http://127.0.0.1:8000';

  return {
    plugins: [react()],
    server: {
      host: true,
      allowedHosts: true, // Cho phép các domain từ cloudflare tunnel và localtunnel
      port: 3000,
      watch: {
        usePolling: true
      },
      proxy: {
        '/api': {
          target: apiUrl,
          changeOrigin: true,
          secure: false,
        },
        '/storage': {
          target: apiUrl,
          changeOrigin: true,
          secure: false,
        }
      }
    }
  }
})
