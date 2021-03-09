#!/usr/bin/env python
# -*- coding: utf-8 -*-

from loguru import logger
from tqdm import tqdm

# -------------------- NerApp --------------------
from theta.modeling.app import NerApp


class MyApp(NerApp):
    def __init__(self,
                 experiment_params,
                 ner_labels: list,
                 ner_connections: list,
                 add_special_args=None):

        super(MyApp, self).__init__(experiment_params, ner_labels,
                                    ner_connections, add_special_args)

    def run(
        self,
        train_data_generator,
        test_data_generator,
        generate_submission=None,
        eval_data_generator=None,
    ):

        args = self.args

        if args.preapre_data:
            logger.info(f"Prepare data.")
        else:
            super(MyApp, self).run(train_data_generator, test_data_generator,
                                   generate_submission, eval_data_generator)


# -------------------- Main --------------------
def main():
    # -------- Customized arguments --------
    def add_special_args(parser):
        parser.add_argument("--preapre_data",
                            action='store_true',
                            help="Preapre data.")
        return parser

    app = MyApp(experiment_params,
                ner_labels=ner_labels,
                ner_connections=ner_connections,
                add_special_args=add_special_args)

    app.run(train_data_generator,
            test_data_generator,
            generate_submission=generate_submission,
            eval_data_generator=eval_data_generator)


# -------------------- Parameters and data --------------------
from cluener import (generate_submission, ner_connections, ner_labels,
                     train_data_generator, test_data_generator,
                     eval_data_generator)
from cluener_params import experiment_params
experiment_params.ner_params.ner_labels = ner_labels

if __name__ == '__main__':
    main()
