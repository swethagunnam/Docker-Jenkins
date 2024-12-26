FROM python:3.12.0b3-alpine3.18
COPY . /application
WORKDIR /application
COPY requirements.txt .
RUN apk add --no-cache gcc g++ musl-dev libffi-dev openssl-dev python3-dev make
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]