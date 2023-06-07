const PROJECT = {
    production: true,
    conf: 'configs',
    copy: {
        initts: {
            config: {
                from: './configs/src/initts/',
                to: 'configs/',
            },
            logos: {
                from: './extra/initts/logos',
                to: 'logos/',
            },
            root: {
                from: './assets/initts/copy/root',
                to: '',
            },
        },
    },
};

export default PROJECT;
