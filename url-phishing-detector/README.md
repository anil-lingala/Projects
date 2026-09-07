# URL Phishing Detector

A machine learning-based malicious/phishing URL detector built for CS6301. It combines a trained Random Forest classifier with a domain blacklist and the Google Safe Browsing API, served through a Streamlit web app.

## Overview

Given a URL, the app returns one of three verdicts — **safe**, **suspicious**, or **dangerous** — along with a confidence score, by combining three signals:

1. **ML model** — a `RandomForestClassifier` trained on lexical/structural features extracted from the URL (HTTPS usage, `@` symbols, IP addresses in the host, suspicious keywords like "login"/"verify", URL length, lookalike-domain detection via Levenshtein distance, dot/dash/subdomain counts, special character and digit counts, port numbers, and Shannon entropy).
2. **Blacklist filtering** — checks the URL's domain against a public list of known malicious domains.
3. **Google Safe Browsing API** — queries Google's threat intelligence for malware, social engineering, unwanted software, and potentially harmful application flags.

Known/trusted domains (Google, PayPal, Amazon, etc.) are treated as safe by default, and a lookalike check flags domains that are suspiciously close (edit distance ≤ 2) to a trusted domain — e.g. `paypa1.com` vs `paypal.com`.

## Project structure

- `CS6301_url_phishing_detector.py` — the full project source (originally a Google Colab notebook): feature extraction, model training, blacklist filtering, Google Safe Browsing integration, and the generated Streamlit app (`app.py`), plus code to launch the app with a public Cloudflare tunnel from Colab.

Running the script trains the model, writes out `app.py` (the Streamlit front end), and launches it locally with a public tunnel URL for quick sharing/demoing from a Colab notebook.

## Setup

```bash
pip install -r requirements.txt
```

The dataset is pulled automatically from Kaggle via `kagglehub` (`taruntiwarihp/phishing-site-urls`), so a [Kaggle account/API token](https://www.kaggle.com/docs/api) is required.

### Google Safe Browsing API key

The app optionally checks URLs against the Google Safe Browsing API. Set your own API key as an environment variable rather than hardcoding it:

```bash
export GOOGLE_SAFE_BROWSING_API_KEY="your-api-key-here"
```

If no key is set, the app skips this check and relies on the ML model and blacklist.

## Running

The script is written to run top-to-bottom in a notebook (e.g. Google Colab). It will:

1. Download the phishing URL dataset and train the Random Forest model.
2. Save the trained model to `url_model.pkl`.
3. Generate `app.py` (the Streamlit app).
4. Launch Streamlit and expose it via a Cloudflare tunnel for a shareable public URL.

To run the generated Streamlit app on its own once `app.py` and `url_model.pkl` exist:

```bash
streamlit run app.py
```

## Team

- Hani — Streamlit app
- Brandon — Blacklist filtering
- Anil — Dataset preprocessing / ML model training

## Disclaimer

This is a class project (CS6301) built for educational purposes and is not intended for production security use.
