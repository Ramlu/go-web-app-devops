FROM golang:1.23-alpine AS base

# Step 2: Set the Current Working Directory inside the container
WORKDIR /app

# Step 3: Copy the Go Modules files and download the dependencies
COPY go.mod ./

RUN go mod donwload 

# Step 4: Copy the entire Go source code into the container
COPY . .

# Step 5: Build the Go app
RUN go build -o main .

# Step 6: Start a new stage for a smaller image using Alpine
FROM gcr.io/distroless/base 

# Step 9: Copy the compiled binary from the builder stage
COPY --from=base /app/main .

COPY --from=base /app/static .

# Step 10: Expose the port your app will run on (optional)
EXPOSE 8080

# Step 11: Run the Go binary
CMD ["./main"]

# CMD ["go","run","main.go"]