package ent

//go:generate elk generate -s ./schema -t ./
//go:generate elk generate handler -s ./schema -t ./
//go:generate elk generate flutter -s ./schema -t ../../client/lib/generated/

// go:generate go run github.com/masseelch/elk/cmd/elk generate -s ./schema -t ./
// go:generate go run github.com/masseelch/elk/cmd/elk generate handler -s ./schema -t ./
// go:generate go run github.com/masseelch/elk/cmd/elk generate flutter -s ./schema -t ../../client/lib/generated/