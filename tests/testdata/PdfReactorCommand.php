<?php

namespace App\Command;

use Pimcore\Console\AbstractCommand;
use Pimcore\Web2Print\Processor;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class PdfReactorCommand extends AbstractCommand
{
    protected function configure(): void
    {
        $this->setName('app:pdf-reactor');
    }

    /**
     * @param InputInterface $input
     * @param OutputInterface $output
     *
     * @return int
     *
     * @throws \Exception
     */
    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $pdf = Processor::getInstance()->startPdfGeneration(75);

        if ($pdf) {
            return 0;
        }

        return 1;
    }
}
