interface FromTo {
    [name: string]: {
        from: string;
        to: string;
    };
}

interface PrCopy {
    initts: FromTo;
}

interface ConfConPrT {
    copy: PrCopy;
    conf: string;
    production: boolean;
}

export { ConfConPrT, FromTo };
